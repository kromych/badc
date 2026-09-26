
inline_asm_x64_callee_saved_operands.x64:	file format elf64-x86-64

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

<id>:
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0xa, %eax
               	movl	$0x14, %ecx
               	movl	$0x1e, %edx
               	movl	$0x28, %esi
               	movl	$0x32, %edi
               	movq	%rax, %rbx
               	movq	%rcx, %r12
               	movq	%rdx, %r13
               	movq	%rsi, %r14
               	movq	%rdi, %r15
               	addq	$0x1, %rbx
               	addq	$0x2, %r12
               	addq	$0x3, %r13
               	addq	$0x4, %r14
               	addq	$0x5, %r15
               	leaq	(%rbx,%r12), %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	cmpq	$0xa5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movl	$0x5, %edi
               	movl	$0x6, %r8d
               	movl	$0x7, %r9d
               	movl	$0x8, %ebx
               	movl	$0x9, %r12d
               	movq	%rbx, %r10
               	movq	%rcx, %rbx
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	%rdi, %rsi
               	movq	%r8, %rdi
               	movq	%r9, %r8
               	movq	%r10, %r9
               	addq	$0x1, %rax
               	addq	$0x1, %rbx
               	addq	$0x1, %rcx
               	addq	$0x1, %rdx
               	addq	$0x1, %rsi
               	addq	$0x1, %rdi
               	addq	$0x1, %r8
               	addq	$0x1, %r9
               	addq	$0x1, %r12
               	addq	%rbx, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%r12, %rax
               	cmpq	$0x36, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	movl	$0x5, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %r12
               	movl	$0x7, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %r13
               	movl	$0xb, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %r14
               	movl	$0xd, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %r15
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movq	%rax, %r10
               	movl	$0x7d0, %r11d           # imm = 0x7D0
               	addq	%r11, %r10
               	addq	$0x11, %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	movq	%r12, %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	addq	0x38(%rsp), %rax
               	addq	$0x7d0, %rax            # imm = 0x7D0
               	cmpq	$0x1428, %rax           # imm = 0x1428
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
