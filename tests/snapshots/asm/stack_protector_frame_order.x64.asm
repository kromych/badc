
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
               	xorl	%r11d, %r11d
               	movl	$0x3, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movslq	(%rax), %rdx
               	xorl	%eax, %eax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	movsbq	(%rax), %rcx
               	movsbq	0xf(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorl	%r11d, %r11d
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x9, (%rax)
               	leaq	0x4(%rax), %rcx
               	xorl	%eax, %eax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movb	$0x4, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rcx
               	movsbq	0xb(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorl	%r11d, %r11d
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorl	%r11d, %r11d
               	leave
               	retq
