
multidim_array_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	0x14(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x20(%rax), %ecx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	0x24(%rax), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x0, 0x28(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	0x3c(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x40(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	0x60(%rax), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, 0x50(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	0x24(%rcx), %edx
               	movl	0x24(%rax), %esi
               	cmpl	%esi, %edx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	0x60(%rcx), %ecx
               	movl	0x60(%rax), %eax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movl	0x18(%rax), %ecx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	cmpl	$0x0, 0x20(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorl	%eax, %eax
               	retq
