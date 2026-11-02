
const_addr_multidim_array_elem.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x300, %rcx            # imm = 0x300
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x190, %rcx            # imm = 0x190
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x80, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x48, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
