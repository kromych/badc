
member_store_constant_readback.x64:	file format elf64-x86-64

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
               	xorl	%ecx, %ecx
               	movb	$0x20, <rip> # <addr>
               	movl	$0x80008080, <rip> # imm = 0x80008080
                                                # <addr>
               	movw	$0x8000, <rip> # imm = 0x8000
                                                # <addr>
               	movabsq	$-0x7fffffff80000000, %rax # imm = 0x8000000080000000
               	movq	%rax, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movb	$0x1, <rip> # <addr>
               	movw	$0x203, <rip> # imm = 0x203
                                                # <addr>
               	movq	%rax, <rip> # <addr>
               	movb	$0x4, <rip> # <addr>
               	movb	$0x9, <rip> # <addr>
               	movb	$0x4, <rip> # <addr>
               	movw	$0x905, <rip> # imm = 0x905
                                                # <addr>
               	movq	<rip>, %rax # <addr>
               	movb	$0x7, (%rax)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x20, %eax
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0x7, %edx
               	cmoveq	%rcx, %rax
               	movb	$0x6, <rip> # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	cmpl	$0x6, %ecx
               	cmovneq	%rdx, %rax
               	retq
