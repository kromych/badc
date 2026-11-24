
stack_protector_frame_order.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	movq	%fs:0x28, %r11
               	movq	%r11, 0x18(%rsp)
               	xorl	%r11d, %r11d
               	xorl	%eax, %eax
               	movb	$0x3, (%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsbq	(%rsp), %rax
               	movsbq	0xf(%rsp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%fs:0x28, %r11
               	cmpq	0x18(%rsp), %r11
               	je	<addr>
               	callq	<addr>
               	xorl	%r11d, %r11d
               	addq	$0x28, %rsp
               	retq
               	leaq	(%rsp), %rax
               	movl	$0x9, (%rsp)
               	leaq	0x4(%rax), %rcx
               	xorl	%eax, %eax
               	movb	$0x4, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	(%rsp), %eax
               	movsbq	0xb(%rsp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%fs:0x28, %r11
               	cmpq	0x18(%rsp), %r11
               	je	<addr>
               	callq	<addr>
               	xorl	%r11d, %r11d
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	movq	%fs:0x28, %r11
               	cmpq	0x18(%rsp), %r11
               	je	<addr>
               	callq	<addr>
               	xorl	%r11d, %r11d
               	addq	$0x28, %rsp
               	retq
