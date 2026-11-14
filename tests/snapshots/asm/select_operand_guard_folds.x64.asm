
select_operand_guard_folds.x64:	file format elf64-x86-64

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

<add_page>:
               	movslq	<rip>, %rax # <addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
               	orq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	andq	$0x3, %rax
               	retq

<main>:
               	movq	$0x0, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	testl	$0x400000, %ecx         # imm = 0x400000
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	$0x400000, <rip> # imm = 0x400000
                                                # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	testl	$0x400000, %ecx         # imm = 0x400000
               	je	<addr>
               	movl	$0x0, <rip> # <addr>
               	movq	$0x1000, <rip> # imm = 0x1000
                                                # <addr>
               	movl	$0x1, <rip> # <addr>
               	movq	$0x1001, <rip> # imm = 0x1001
                                                # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x1001, %rcx           # imm = 0x1001
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x1, <rip> # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	%eax, <rip> # <addr>
               	retq
               	movl	$0x7, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x2, %eax
               	retq
