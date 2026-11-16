
designator_override_and_braced_string.x64:	file format elf64-x86-64

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

<take>:
               	movsbq	(%rdi), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movsbq	0x1(%rdi), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movsbq	0x2(%rdi), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	cmpb	$0x0, 0x3(%rdi)
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

<main>:
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x68, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6f, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x68, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
