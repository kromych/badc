
u16_load_store.x64:	file format elf64-x86-64

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
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movzwq	0x8(%rcx), %r10
               	movw	%r10w, 0x8(%rax)
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movw	$0x4241, -0xe(%rbp)     # imm = 0x4241
               	cmpb	$0x0, -0x10(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0xf(%rbp)
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsbq	-0xe(%rbp), %rax
               	cmpl	$0x41, %eax
               	jne	<addr>
               	movsbq	-0xd(%rbp), %rax
               	cmpl	$0x42, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpb	$0x0, -0xc(%rbp)
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzwq	-0x1f(%rbp), %rax
               	xorq	$0x4342, %rax           # imm = 0x4342
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
