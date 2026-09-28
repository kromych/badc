
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
               	leaq	-0x10(%rbp), %rax
               	movw	$0x4241, 0x2(%rax)      # imm = 0x4241
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	cmpb	$0x0, 0x1(%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsbq	0x2(%rax), %rcx
               	cmpl	$0x41, %ecx
               	jne	<addr>
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x42, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpb	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzwq	0x1(%rax), %rax
               	xorq	$0x4342, %rax           # imm = 0x4342
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
