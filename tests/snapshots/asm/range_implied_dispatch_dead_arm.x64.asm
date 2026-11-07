
range_implied_dispatch_dead_arm.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	<rip>, %rdx # <addr>
               	addq	%rax, %rdx
               	movq	%rdx, <rip> # <addr>
               	incq	%rcx
               	cmpl	$0x1, %eax
               	jb	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jb	<addr>
               	movl	$0x2, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jb	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	$0x1, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1092, %rax           # imm = 0x1092
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	$0x1092, <rip> # imm = 0x1092
                                                # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1092, %rax           # imm = 0x1092
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x3, %eax
               	retq
