
thread_local_zero_images.x64:	file format elf64-x86-64

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

<block>:
               	movq	%fs:0x0, %rax
               	addq	$-0x1c, %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0xe8, %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rax
               	movq	%fs:0x0, %rax
               	addq	$-0x100, %rax
               	movq	(%rax), %rax
               	movl	(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xf8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xf0, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x40, %rax
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	movq	%fs:0x0, %rcx
               	addq	$-0xc0, %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0xe0, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	jne	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0xc0, %rcx
               	movb	$0x1, 0x63(%rcx)
               	movq	%fs:0x0, %rdx
               	addq	$-0x40, %rdx
               	movb	$0x2, 0x1f(%rdx)
               	movq	%fs:0x0, %rsi
               	addq	$-0x20, %rsi
               	movl	$0x4, (%rsi)
               	movl	$0x9, 0xc(%rax)
               	movq	%fs:0x0, %rax
               	addq	$-0xf8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0xf0, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x100, %rax
               	movq	(%rax), %rax
               	movl	(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movsbq	0x63(%rcx), %rax
               	movsbq	0x1f(%rdx), %rcx
               	addq	%rcx, %rax
               	movl	(%rsi), %ecx
               	addq	%rcx, %rax
               	addq	$0x9, %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movl	$0x5, %eax
               	popq	%r11
               	retq
