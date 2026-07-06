
variadic_fnptr_proto_erased.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<vsum>:
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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	movslq	-0xe0(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jl	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movslq	%eax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq

<via_field>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	(%rdi), %rax
               	movl	$0x4, %edi
               	movl	$0x64, %esi
               	movl	$0xc8, %edx
               	movl	$0x12c, %ecx            # imm = 0x12C
               	movl	$0x190, %r8d            # imm = 0x190
               	movq	%rax, %r9
               	movb	$0x0, %al
               	callq	*%r9
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<via_array>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	(%rdi), %rax
               	movl	$0x3, %edi
               	movl	$0xb, %esi
               	movl	$0x16, %edx
               	movl	$0x21, %ecx
               	movq	%rax, %r8
               	movb	$0x0, %al
               	callq	*%r8
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<via_inline_field>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	(%rdi), %rax
               	movl	$0x2, %edi
               	movl	$0x28, %esi
               	movl	$0x3c, %edx
               	movq	%rax, %rcx
               	movb	$0x0, %al
               	callq	*%rcx
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rcx      # <addr>
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	-<rip>, %rcx      # <addr>
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	-<rip>, %rcx      # <addr>
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x42, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
