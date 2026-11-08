
memory_ops.x64:	file format elf64-x86-64

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
               	pushq	%r12
               	pushq	%rbx
               	movl	$0xa, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0xa, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movb	$0x41, (%r12)
               	movb	$0x41, 0x1(%r12)
               	movb	$0x41, 0x2(%r12)
               	movb	$0x41, 0x3(%r12)
               	movb	$0x41, 0x4(%r12)
               	movb	$0x41, 0x5(%r12)
               	movb	$0x41, 0x6(%r12)
               	movb	$0x41, 0x7(%r12)
               	movb	$0x41, 0x8(%r12)
               	movb	$0x0, 0x9(%r12)
               	movb	$0x41, (%rbx)
               	movb	$0x41, 0x1(%rbx)
               	movb	$0x41, 0x2(%rbx)
               	movb	$0x41, 0x3(%rbx)
               	movb	$0x41, 0x4(%rbx)
               	movb	$0x41, 0x5(%rbx)
               	movb	$0x41, 0x6(%rbx)
               	movb	$0x41, 0x7(%rbx)
               	movb	$0x41, 0x8(%rbx)
               	movb	$0x0, 0x9(%rbx)
               	movl	$0xa, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movb	$0x42, 0x5(%rbx)
               	movl	$0xa, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
