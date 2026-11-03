
undeclared_library_calls_keep_the_header_types.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	leaq	<rip>, %rdi
               	movsd	0x8(%rsp), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movsd	0x8(%rsp), %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	xorl	%ecx, %ecx
               	cmpl	$0x5, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	orq	%rcx, %rax
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
