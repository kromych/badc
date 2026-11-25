
struct_stat_abi_size.x64:	file format elf64-x86-64

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
               	subq	$0xc0, %rsp
               	pushq	%rbx
               	leaq	0x18(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	movzbq	0x14(%rax), %r10
               	movb	%r10b, 0x14(%rdi)
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	movl	$0x10, %edx
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movq	$0x0, 0x30(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	movq	$0x0, 0x40(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	movq	$0x0, 0x50(%rsp)
               	movq	$0x0, 0x58(%rsp)
               	movq	$0x0, 0x60(%rsp)
               	movq	$0x0, 0x68(%rsp)
               	movq	$0x0, 0x70(%rsp)
               	movq	$0x0, 0x78(%rsp)
               	movq	$0x0, 0x80(%rsp)
               	movq	$0x0, 0x88(%rsp)
               	movq	$0x0, 0x90(%rsp)
               	movq	$0x0, 0x98(%rsp)
               	movq	$0x0, 0xa0(%rsp)
               	movq	$0x0, 0xa8(%rsp)
               	movq	$0x0, 0xb0(%rsp)
               	movq	$0x0, 0xb8(%rsp)
               	movq	%rbx, %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movq	0x60(%rsp), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	0x48(%rsp), %eax
               	andq	$0xf000, %rax           # imm = 0xF000
               	cmpl	$0x8000, %eax           # imm = 0x8000
               	je	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
