
struct_array_designator_resume.x64:	file format elf64-x86-64

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
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x0, 0x10(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x1c(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x1c(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	xorl	%eax, %eax
               	retq
