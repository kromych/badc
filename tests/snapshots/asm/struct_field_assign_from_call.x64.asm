
struct_field_assign_from_call.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movl	$0x4, <rip> # <addr>
               	movq	$0x1234abcd, <rip> # imm = 0x1234ABCD
                                                # <addr>
               	movl	$0x4, <rip> # <addr>
               	movq	$0x1234abcd, <rip> # imm = 0x1234ABCD
                                                # <addr>
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	jne	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	movl	<rip>, %r8d # <addr>
               	movl	<rip>, %r9d # <addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	cmpq	$0x1234abcd, %rcx       # imm = 0x1234ABCD
               	jne	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
