
call_arg_low_word.x64:	file format elf64-x86-64

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

<scale>:
               	movl	%edi, %eax
               	leaq	(%rax,%rax,2), %rax
               	retq

<widen>:
               	movslq	%edi, %rax
               	retq

<halve>:
               	movl	%edi, %eax
               	shrq	%rax
               	retq

<sum>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	(%rdi,%rsi), %rax
               	retq

<pick>:
               	movslq	%esi, %rsi
               	movq	(%rdi,%rsi,8), %rax
               	retq

<pick_u>:
               	movl	%esi, %eax
               	movq	(%rdi,%rax,8), %rax
               	retq

<byte>:
               	movsbq	%dil, %rax
               	retq

<half>:
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<via_scale>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	orq	$0x1, %rdi
               	popq	%rbp
               	jmp	<addr>

<via_widen>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	incq	%rdi
               	popq	%rbp
               	jmp	<addr>

<via_halve>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	$0x2, %rdi
               	popq	%rbp
               	jmp	<addr>

<via_sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	decq	%rsi
               	popq	%rbp
               	jmp	<addr>

<via_pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x5, %rsi
               	popq	%rbp
               	jmp	<addr>

<via_pick_u>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	incq	%rsi
               	popq	%rbp
               	jmp	<addr>

<via_byte>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	<addr>

<via_half>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	popq	%rbp
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$-0x21524110fffffffc, %rax # imm = 0xDEADBEEF00000004
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0x12345678fffffffc, %rax # imm = 0x12345678FFFFFFFC
               	movq	%rax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rdi
               	movq	-0x8(%rbp), %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rdi
               	movq	-0x10(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	-0x10(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movabsq	$0x12345678ffffff85, %rdi # imm = 0x12345678FFFFFF85
               	callq	<addr>
               	cmpq	$-0x7b, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movabsq	$-0x21524110edcb0002, %rdi # imm = 0xDEADBEEF1234FFFE
               	callq	<addr>
               	cmpq	$0xfffe, %rax           # imm = 0xFFFE
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
