
enum_used_before_definition.x64:	file format elf64-x86-64

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

<g>:
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	retq

<g_ref>:
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	retq

<take>:
               	movl	%edi, %eax
               	retq

<store>:
               	movl	%edi, %eax
               	movq	%rax, <rip> # <addr>
               	retq

<id>:
               	movq	%rdi, %rax
               	retq

<make>:
               	leaq	-<rip>, %rax # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movl	<rip>, %ecx # <addr>
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movq	$0x0, <rip> # <addr>
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rbx # <addr>
               	movl	(%rbx), %eax
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	(%rbx), %eax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	movq	$0x0, <rip> # <addr>
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	*%rax
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movl	$0x80000000, <rip> # imm = 0x80000000
                                                # <addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movabsq	$0x7fffffffffff, %r11   # imm = 0x7FFFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	(%rax), %rax
               	xorq	$0xc8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
