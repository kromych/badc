
struct_arg_two_eightbyte.x64:	file format elf64-x86-64

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
               	movl	$0x9, <rip> # <addr>
               	movq	$0x1111, <rip> # imm = 0x1111
                                                # <addr>
               	movl	$0x4, <rip> # <addr>
               	movq	$0x2222, <rip> # imm = 0x2222
                                                # <addr>
               	movl	$0x6, <rip> # <addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x9, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x1111, %rsi           # imm = 0x1111
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x4, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x2222, %rsi           # imm = 0x2222
               	jne	<addr>
               	movq	$0x1111, <rip> # imm = 0x1111
                                                # <addr>
               	movl	$0x4, <rip> # <addr>
               	movq	$0x2222, <rip> # imm = 0x2222
                                                # <addr>
               	movl	$0x6, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x3, %eax
               	retq
