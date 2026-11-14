
static_locals.x64:	file format elf64-x86-64

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
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xca, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	0x1(%rcx), %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0x131, %eax            # imm = 0x131
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x64, <rip> # <addr>
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	addq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	addq	%rdx, %rcx
               	cmpl	$0xca, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	$0x3e9, %ecx            # imm = 0x3E9
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	$0x3ea, %ecx            # imm = 0x3EA
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	retq
