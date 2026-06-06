
variadic_via_fnptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r13
               	movl	(%r13), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r13), %r10
               	addl	$0x8, (%r13)
               	jmp	<addr>
               	movq	0x8(%r13), %r10
               	addq	$0x8, 0x8(%r13)
               	movq	%r10, %rax
               	movslq	(%rax), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r13
               	movl	(%r13), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r13), %r10
               	addl	$0x8, (%r13)
               	jmp	<addr>
               	movq	0x8(%r13), %r10
               	addq	$0x8, 0x8(%r13)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r13
               	movl	(%r13), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r13), %r10
               	addl	$0x8, (%r13)
               	jmp	<addr>
               	movq	0x8(%r13), %r10
               	addq	$0x8, 0x8(%r13)
               	movq	%r10, %rdx
               	movslq	(%rdx), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movslq	-0xe0(%rbp), %rsi
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	movslq	%esi, %rsi
               	imulq	$0x64, %rax, %rax
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	imulq	$0xa, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x9, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax      # <addr>
               	movl	$0x9, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movq	%rax, %r11
               	movb	$0x0, %al
               	callq	*%r11
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax      # <addr>
               	movl	$0x9, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movq	%rax, %r11
               	movb	$0x0, %al
               	callq	*%r11
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
