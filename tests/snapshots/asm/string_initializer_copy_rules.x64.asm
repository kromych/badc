
string_initializer_copy_rules.x64:	file format elf64-x86-64

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
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x61, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x63, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x66, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x67, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x66, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x67, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x68, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x69, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x78, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x79, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x69, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	xorl	%eax, %eax
               	retq
