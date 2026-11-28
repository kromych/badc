
tentative_array_sized_later.x64:	file format elf64-x86-64

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

<main>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rdx, %rcx
               	cmpw	$0x0, (%rcx)
               	jne	<addr>
               	nopl	(%rax)
               	cmpw	$0x0, 0x2(%rcx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x48, %eax
               	jl	<addr>
               	movw	$0x7, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x9, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	movl	$0x6, %ecx
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x5, %edx
               	cmovneq	%rcx, %rax
               	retq
               	movl	$0x2, %eax
               	retq
