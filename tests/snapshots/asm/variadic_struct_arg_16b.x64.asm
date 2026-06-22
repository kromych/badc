
variadic_struct_arg_16b.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sumv>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rdi, -0xf0(%rbp)
               	movq	%rsi, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xc0(%rbp,%riz)
               	movsd	%xmm1, -0xb0(%rbp,%riz)
               	movsd	%xmm2, -0xa0(%rbp,%riz)
               	movsd	%xmm3, -0x90(%rbp,%riz)
               	movsd	%xmm4, -0x80(%rbp,%riz)
               	movsd	%xmm5, -0x70(%rbp,%riz)
               	movsd	%xmm6, -0x60(%rbp,%riz)
               	movsd	%xmm7, -0x50(%rbp,%riz)
               	movq	%r13, (%rsp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xf0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xf0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	movslq	-0xf0(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r13
               	movl	(%r13), %r10d
               	cmpq	$0x28, %r10
               	jae	<addr>
               	addq	0x10(%r13), %r10
               	addl	$0x10, (%r13)
               	jmp	<addr>
               	movq	0x8(%r13), %r10
               	addq	$0x10, 0x8(%r13)
               	movq	%r10, %rdx
               	leaq	-0x38(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rdx
               	leaq	-0x38(%rbp), %rsi
               	movq	0x8(%rsi), %rsi
               	shlq	$0x1, %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rsp), %r13
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	movl	$0x3, %edi
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rcx
               	subq	$0x10, %rsp
               	movq	%rcx, %r10
               	movq	(%r10), %r13
               	movq	%r13, (%rsp)
               	movq	0x8(%r10), %r13
               	movq	%r13, 0x8(%rsp)
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	movq	0x8(%rcx), %r8
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
