
narrow_remainder_rebuilt.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0xffffffff, <rip> # imm = 0xFFFFFFFF
                                                # <addr>
               	movl	$0xffffffff, <rip> # imm = 0xFFFFFFFF
                                                # <addr>
               	movl	$0xffffffff, <rip> # imm = 0xFFFFFFFF
                                                # <addr>
               	movl	$0xffffffff, <rip> # imm = 0xFFFFFFFF
                                                # <addr>
               	movl	$0xffffffff, <rip> # imm = 0xFFFFFFFF
                                                # <addr>
               	movl	$0xffffffff, <rip> # imm = 0xFFFFFFFF
                                                # <addr>
               	movl	$0xffffffff, <rip> # imm = 0xFFFFFFFF
                                                # <addr>
               	movl	$0xffffffff, <rip> # imm = 0xFFFFFFFF
                                                # <addr>
               	movl	<rip>, %ecx # <addr>
               	movl	<rip>, %esi # <addr>
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	movq	%rdx, %rbx
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x4, %rcx
               	andq	%rbx, %rcx
               	movl	(%rax,%rcx,4), %ecx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x4, %rcx
               	andq	%rbx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x4, %rcx
               	andq	%rbx, %rcx
               	movl	(%rax,%rcx,4), %ecx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x4, %rcx
               	andq	%rbx, %rcx
               	movl	(%rax,%rcx,4), %ecx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x4, %rcx
               	andq	%rbx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x4, %rcx
               	andq	%rbx, %rcx
               	movl	(%rax,%rcx,4), %ecx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x4, %rcx
               	andq	%rbx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x4, %rcx
               	andq	%rbx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	$0x3, %rbx
               	testl	%ebx, %ebx
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq
