
case_range_wide.x64:	file format elf64-x86-64

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

<classify_u>:
               	movl	%edi, %eax
               	cmpl	$0x100000, %eax         # imm = 0x100000
               	jae	<addr>
               	cmpl	$0x7, %eax
               	jae	<addr>
               	movl	$0xf0000000, %r11d      # imm = 0xF0000000
               	movq	%rax, %rcx
               	cmpl	%r11d, %eax
               	jae	<addr>
               	cmpl	$0x5, %eax
               	jb	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x64, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x9, %eax
               	jbe	<addr>
               	jmp	<addr>
               	cmpl	$0x1fffff, %eax         # imm = 0x1FFFFF
               	ja	<addr>
               	movl	$0x1, %eax
               	retq

<classify_s>:
               	movslq	%edi, %rdi
               	cmpl	$-0x64, %edi
               	jge	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	cmpl	$-0x32, %edi
               	jg	<addr>
               	movl	$0xa, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x100000, %edi         # imm = 0x100000
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x1fffff, %edi         # imm = 0x1FFFFF
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x16e360, %edi         # imm = 0x16E360
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xfffff, %edi          # imm = 0xFFFFF
               	movq	(%rbx), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x200000, %edi         # imm = 0x200000
               	movq	(%rbx), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	$0x7, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	$0x9, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf0000000, %edi       # imm = 0xF0000000
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movq	(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xefffffff, %edi       # imm = 0xEFFFFFFF
               	movq	(%rbx), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x64, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movq	$-0x32, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movq	$-0x4b, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x65, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movq	$-0x31, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
