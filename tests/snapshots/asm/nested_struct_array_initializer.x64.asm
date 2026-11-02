
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
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x13, %eax
               	je	<addr>
               	movl	$0x25, %eax
               	retq
               	xorl	%eax, %eax
               	retq
