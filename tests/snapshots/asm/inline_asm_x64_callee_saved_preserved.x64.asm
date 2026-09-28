
inline_asm_x64_callee_saved_preserved.x64:	file format elf64-x86-64

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

<clobber_heavy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
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
               	movq	$0x65, %rbx
               	movq	$0x67, %r12
               	movq	$0x6b, %r13
               	movq	$0x6d, %r14
               	movq	$0x71, %r15
               	callq	<addr>
               	movq	%rax, %r9
               	addq	%r9, %r9
               	addq	%rbx, %r9
               	addq	%r9, %r9
               	addq	%r12, %r9
               	addq	%r9, %r9
               	addq	%r13, %r9
               	addq	%r9, %r9
               	addq	%r14, %r9
               	addq	%r9, %r9
               	addq	%r15, %r9
               	cmpq	$0x211f, %r9            # imm = 0x211F
               	je	<addr>
               	movl	$0x2, %eax
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
