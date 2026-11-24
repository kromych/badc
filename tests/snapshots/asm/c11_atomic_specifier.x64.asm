
c11_atomic_specifier.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	movb	$-0x38, 0x8(%rsp)
               	movw	$0x9c40, 0x18(%rsp)     # imm = 0x9C40
               	movl	$0x11223344, 0x20(%rsp) # imm = 0x11223344
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, 0x28(%rsp)
               	leaq	0x8(%rsp), %rax
               	movzbq	(%rax), %rcx
               	cmpl	$0xc8, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	0x18(%rsp), %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	$0x9c40, %ecx           # imm = 0x9C40
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	0x20(%rsp), %rcx
               	movl	(%rcx), %ecx
               	cmpl	$0x11223344, %ecx       # imm = 0x11223344
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	0x28(%rsp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x48, %rsp
               	retq
               	movzbq	(%rax), %rcx
               	cmpl	$0xc8, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0xfa, %ecx
               	movq	%rcx, %r10
               	xchgb	%r10b, (%rax)
               	movzbq	(%rax), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0xfffffff9, 0x10(%rsp) # imm = 0xFFFFFFF9
               	movq	$0x63, 0x30(%rsp)
               	movw	$0xd, 0x38(%rsp)
               	leaq	0x10(%rsp), %rax
               	movl	(%rax), %ecx
               	cmpl	$-0x7, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	0x30(%rsp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	0x38(%rsp), %rcx
               	movzwq	(%rcx), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xd, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x15, %ecx
               	movq	%rcx, %r10
               	xchgl	%r10d, (%rax)
               	movl	(%rax), %eax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
