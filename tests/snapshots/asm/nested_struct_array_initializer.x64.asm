
nested_struct_array_initializer.x64:	file format elf64-x86-64

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
               	cmpl	$0x64, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	0x4(%rax), %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movl	0xc(%rax), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movl	0x10(%rax), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movl	0x14(%rax), %ecx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movl	0x18(%rax), %ecx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movl	0x1c(%rax), %eax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	0x4(%rax), %ecx
               	cmpl	$0x14, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movl	0xc(%rax), %eax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	movl	0x4(%rax), %ecx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	movl	0x8(%rax), %ecx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	movl	0xc(%rax), %ecx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	movl	0x10(%rax), %ecx
               	cmpl	$0xd, %ecx
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	movl	0x14(%rax), %ecx
               	cmpl	$0x11, %ecx
               	je	<addr>
               	movl	$0x24, %eax
               	retq
               	movl	0x18(%rax), %eax
               	cmpl	$0x13, %eax
               	je	<addr>
               	movl	$0x25, %eax
               	retq
               	xorl	%eax, %eax
               	retq
