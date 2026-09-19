
type_name_forms.x64:	file format elf64-x86-64

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

<add1>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<sum_va>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movups	%xmm2, -0x80(%rbp,%riz)
               	movups	%xmm3, -0x70(%rbp,%riz)
               	movups	%xmm4, -0x60(%rbp,%riz)
               	movups	%xmm5, -0x50(%rbp,%riz)
               	movups	%xmm6, -0x40(%rbp,%riz)
               	movups	%xmm7, -0x30(%rbp,%riz)
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movq	(%rax), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movq	(%rcx), %rcx
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
               	movq	(%rdx), %r12
               	movsbq	(%rax), %rdi
               	callq	*%rcx
               	movslq	0x4(%r12), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rbx
               	movslq	-0xd0(%rbp), %rax
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, -0xd0(%rbp)
               	testl	%eax, %eax
               	jg	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rcx
               	movslq	0x14(%rcx), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movslq	0x4(%rcx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movslq	0xc(%rcx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	leaq	<rip>, %rsi
               	leaq	-<rip>, %rdx      # <addr>
               	leaq	<rip>, %r8
               	leaq	0xc(%rcx), %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0xcc, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
