
overaligned_vector_object.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x13, <rip> # <addr>
               	movl	$0x17, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x17, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	0x10(%rsp), %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	(%rsp), %rax
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	$0xb, 0x10(%rsp)
               	movl	$0xd, 0x1c(%rsp)
               	movl	$0x11, 0x4(%rsp)
               	movl	0x1c(%rsp), %eax
               	addq	$0xb, %rax
               	addq	$0x11, %rax
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
