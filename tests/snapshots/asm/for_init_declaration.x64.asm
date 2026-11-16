
for_init_declaration.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x200000001, %rdx      # imm = 0x200000001
               	movq	%rdx, <rip> # <addr>
               	leaq	0xc(%rax), %rdx
               	movl	$0x4, <rip> # <addr>
               	cmpq	%rdx, %rax
               	jae	<addr>
               	movl	(%rax), %esi
               	addq	%rsi, %rcx
               	addq	$0x4, %rax
               	cmpq	%rdx, %rax
               	jb	<addr>
               	cmpl	$0x7, %ecx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax # <addr>
               	xorl	%esi, %esi
               	movabsq	$0x200000001, %rcx      # imm = 0x200000001
               	movq	%rcx, <rip> # <addr>
               	leaq	0xc(%rax), %rcx
               	movl	$0x4, <rip> # <addr>
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movl	(%rax), %edx
               	addq	%rdx, %rsi
               	addq	$0x4, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
