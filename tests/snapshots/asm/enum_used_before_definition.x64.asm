
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

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	(%rcx), %ecx
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0x80000000, %edx       # imm = 0x80000000
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x0, (%rax)
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	movq	%rcx, (%rax)
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movl	(%rbx), %eax
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	(%rbx), %eax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	$0x0, (%rax)
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	*%rax
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x80000000, (%rax)     # imm = 0x80000000
               	movl	(%rax), %eax
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	movabsq	$0x7fffffffffff, %r11   # imm = 0x7FFFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xc8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

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
               	leaq	<rip>, %rax
               	movl	%edi, %ecx
               	movq	%rcx, (%rax)
               	retq

<id>:
               	movq	%rdi, %rax
               	retq

<make>:
               	leaq	-<rip>, %rax        # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	popq	%rbp
               	retq
