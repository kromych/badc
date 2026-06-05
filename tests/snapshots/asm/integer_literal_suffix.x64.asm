
integer_literal_suffix.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	movabsq	$0xfffffffff, %r13      # imm = 0xFFFFFFFFF
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x24, %eax
               	movl	$0x1, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	subq	$0x1, %rax
               	movabsq	$0xfffffffff, %r13      # imm = 0xFFFFFFFFF
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789, %rax      # imm = 0x123456789
               	addq	$0x1, %rax
               	movabsq	$0x12345678a, %r13      # imm = 0x12345678A
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	cmpq	$-0x1, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	movq	%rax, %rdx
               	cmpq	%r13, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	addq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
