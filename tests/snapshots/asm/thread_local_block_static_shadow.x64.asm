
thread_local_block_static_shadow.x64:	file format elf64-x86-64

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

<bump_x>:
               	movq	%fs:0x0, %rcx
               	addq	$-0x14, %rcx
               	movl	(%rcx), %eax
               	leaq	0x1(%rax), %rdx
               	movl	%edx, (%rcx)
               	retq

<bump_y>:
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movl	(%rax), %ecx
               	addq	$0x2, %rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x18, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x18, %rax
               	movl	$0x9, (%rax)
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
