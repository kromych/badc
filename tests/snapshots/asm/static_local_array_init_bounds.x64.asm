
static_local_array_init_bounds.x64:	file format elf64-x86-64

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
               	cmpl	$0x11, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x33, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x44, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x62, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x78, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x79, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x78, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
