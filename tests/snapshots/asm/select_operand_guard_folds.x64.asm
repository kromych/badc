
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
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	orq	%rdi, %rax
               	movq	%rax, (%rcx)
               	andq	$0x3, %rax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	leaq	<rip>, %rax # <addr>
               	movq	$0x0, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rsi
               	movq	(%rsi), %rsi
               	testl	$0x400000, %esi         # imm = 0x400000
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	$0x400000, (%rax)       # imm = 0x400000
               	movq	(%rcx), %rax
               	movq	(%rax), %rax
               	testl	$0x400000, %eax         # imm = 0x400000
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rax # <addr>
               	movq	$0x1000, (%rax)         # imm = 0x1000
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, (%rcx)
               	leaq	<rip>, %rcx # <addr>
               	movq	$0x1001, (%rcx)         # imm = 0x1001
               	movq	(%rcx), %rcx
               	cmpq	$0x1001, %rcx           # imm = 0x1001
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, (%rcx)
               	leaq	<rip>, %rdx # <addr>
               	cmpl	$0x0, (%rdx)
               	je	<addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rdx)
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	cmpl	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	%eax, (%rcx)
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x2, %eax
               	retq
