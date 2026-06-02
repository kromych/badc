
stdint_widths.x64:	file format elf64-x86-64

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
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	jmp	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xb, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xd, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xf, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x10, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	movabsq	$0x1122334455667788, %r10 # imm = 0x1122334455667788
               	cmpq	%r10, %r11
               	je	<addr>
               	movl	$0x15, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x123456789abcdf0, %r11 # imm = 0xFEDCBA9876543210
               	movabsq	$-0x123456789abcdf0, %r10 # imm = 0xFEDCBA9876543210
               	cmpq	%r10, %r11
               	je	<addr>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %r11d
               	movl	%r11d, -0x18(%rbp)
               	leaq	-0x18(%rbp), %r9
               	movslq	(%r9), %r9
               	cmpq	$0x2a, %r9
               	je	<addr>
               	movl	$0x17, %r11d
               	movq	%r11, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r9
               	movslq	%r9d, %r9
               	cmpq	$-0x1, %r9
               	je	<addr>
               	movl	$0x18, %r11d
               	movq	%r11, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
