
designator_resumes_in_subobject.x64:	file format elf64-x86-64

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
               	movl	0xc(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movsbq	0x8(%rax), %rcx
               	cmpl	$0x78, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x10(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x14(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	xorl	%eax, %eax
               	retq
