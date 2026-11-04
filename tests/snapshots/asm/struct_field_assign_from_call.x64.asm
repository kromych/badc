
struct_field_assign_from_call.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	movl	$0x4, <rip> # <addr>
               	movq	$0x1234abcd, <rip> # imm = 0x1234ABCD
                                                # <addr>
               	movl	$0x4, <rip> # <addr>
               	movq	$0x1234abcd, <rip> # imm = 0x1234ABCD
                                                # <addr>
               	cmpq	$0x1234abcd, %rdx       # imm = 0x1234ABCD
               	jne	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	movl	<rip>, %r8d # <addr>
               	movl	<rip>, %r9d # <addr>
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	cmpq	$0x1234abcd, %rsi       # imm = 0x1234ABCD
               	jne	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
