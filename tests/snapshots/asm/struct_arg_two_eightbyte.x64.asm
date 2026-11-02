
struct_arg_two_eightbyte.x64:	file format elf64-x86-64

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
               	movl	$0x9, <rip> # <addr>
               	movq	$0x1111, <rip> # imm = 0x1111
                                                # <addr>
               	movl	$0x4, <rip> # <addr>
               	movq	$0x2222, <rip> # imm = 0x2222
                                                # <addr>
               	movl	$0x6, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x9, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x1111, %rdx           # imm = 0x1111
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	xorq	$0x4, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x2222, %rdx           # imm = 0x2222
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	xorq	$0x6, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	$0x1111, <rip> # imm = 0x1111
                                                # <addr>
               	movl	$0x4, %eax
               	movl	%eax, <rip> # <addr>
               	movq	$0x2222, <rip> # imm = 0x2222
                                                # <addr>
               	movl	$0x6, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x1111, %rcx           # imm = 0x1111
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	xorq	$0x4, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
