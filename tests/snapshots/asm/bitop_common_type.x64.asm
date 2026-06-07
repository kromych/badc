
bitop_common_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x14006f000, %rax      # imm = 0x14006F000
               	xorq	%rcx, %rcx
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	incq	%rdx
               	movabsq	$0x14006f001, %r13      # imm = 0x14006F001
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rax, %rdx
               	incq	%rdx
               	movabsq	$0x14006f001, %r13      # imm = 0x14006F001
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	xorq	%rcx, %rdx
               	incq	%rdx
               	movabsq	$0x14006f001, %r13      # imm = 0x14006F001
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x14006f001, %rdx      # imm = 0x14006F001
               	decq	%rdx
               	orq	$0xf, %rdx
               	incq	%rdx
               	movabsq	$0x14006f010, %r13      # imm = 0x14006F010
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	movabsq	$0x14006f000, %r13      # imm = 0x14006F000
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	movabsq	$0x14006f000, %r13      # imm = 0x14006F000
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	orq	%rcx, %rax
               	movabsq	$0x100000000, %r13      # imm = 0x100000000
               	cmpq	%r13, %rax
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
