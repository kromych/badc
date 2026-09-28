
return_low_word.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<square>:
               	movq	%rdi, %rax
               	imulq	%rdi, %rax
               	retq

<usquare>:
               	movq	%rdi, %rax
               	imulq	%rdi, %rax
               	retq

<sum_min>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<shalf>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3f, %rax
               	addq	%rdi, %rax
               	sarq	%rax
               	movswq	%ax, %rax
               	retq

<cbyte>:
               	movsbq	%dil, %rax
               	retq

<zero_if>:
               	movq	%rdi, %rax
               	andq	$0x1, %rax
               	retq

<as_long>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<as_ulong>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movl	%eax, %eax
               	popq	%rbp
               	retq

<as_int>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xb505, %edi           # imm = 0xB505
               	callq	<addr>
               	incq	%rax
               	popq	%rbp
               	retq

<as_test>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	jmp	<addr>

<as_index>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rbx,%rax,8), %rax
               	popq	%rbx
               	leave
               	retq

<as_short>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movswq	%ax, %rax
               	popq	%rbp
               	retq

<as_char>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movsbq	%al, %rax
               	popq	%rbp
               	retq

<as_diff>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	decq	%rax
               	popq	%rbp
               	retq

<through_ptr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x10000, %edi          # imm = 0x10000
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xb505, %edi           # imm = 0xB505
               	callq	<addr>
               	cmpq	$-0x7fffede7, %rax      # imm = 0x80001219
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	$-0xb505, %rdi          # imm = 0xFFFF4AFB
               	callq	<addr>
               	cmpq	$-0x7fffede7, %rax      # imm = 0x80001219
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0xb505, %edi           # imm = 0xB505
               	callq	<addr>
               	cmpl	$0x8000121a, %eax       # imm = 0x8000121A
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x10000, %edi          # imm = 0x10000
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movq	$-0x11170, %rdi         # imm = 0xFFFEEE90
               	callq	<addr>
               	cmpq	$0x7748, %rax           # imm = 0x7748
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	$0x30d40, %edi          # imm = 0x30D40
               	callq	<addr>
               	cmpq	$-0x7960, %rax          # imm = 0x86A0
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movq	$-0x1, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	movl	$0x1, %esi
               	callq	<addr>
               	movabsq	$-0x80000001, %r11      # imm = 0xFFFFFFFF7FFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movq	$-0x1, %rsi
               	callq	<addr>
               	cmpq	$0x7ffffffe, %rax       # imm = 0x7FFFFFFE
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	movl	$0x10000, %esi          # imm = 0x10000
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	movl	$0xb505, %esi           # imm = 0xB505
               	callq	<addr>
               	cmpq	$-0x7fffede7, %rax      # imm = 0x80001219
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
