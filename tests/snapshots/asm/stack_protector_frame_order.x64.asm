
stack_protector_frame_order.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%fs:0x28, %r11
               	movq	%r11, -0x8(%rbp)
               	xorq	%r11, %r11
               	movl	$0x3, %eax
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rsi
               	movslq	(%rax), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	movsbq	(%rax), %rcx
               	movsbq	0xf(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	leave
               	retq
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	leaq	0x4(%rax), %rdx
               	movl	$0x4, %esi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rcx
               	movsbq	0xb(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	leave
               	retq
