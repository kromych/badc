
slot_coalesce_block_arrays.x64:	file format elf64-x86-64

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

<tally>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	(%rdi,%rax,8), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x400, %rsp            # imm = 0x400
               	movslq	%edx, %rdx
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	xorl	%eax, %eax
               	cmpl	$0x2, %edi
               	jl	<addr>
               	cmpl	$0x3, %edi
               	jl	<addr>
               	cmpl	$0x4, %edi
               	jl	<addr>
               	xorl	%eax, %eax
               	cmpl	%edx, %eax
               	jge	<addr>
               	leaq	-0x200(%rbp), %rcx
               	leaq	(%rax,%rax,2), %rsi
               	movslq	%esi, %rsi
               	addq	$0x3e8, %rsi            # imm = 0x3E8
               	movq	%rsi, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	movq	%rdx, %rsi
               	callq	<addr>
               	leave
               	retq
               	xorl	%ecx, %ecx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movq	%rsi, %r8
               	xorq	%rcx, %r8
               	movq	%r8, (%rdi,%rcx,8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movq	%rsi, %r8
               	subq	%rcx, %r8
               	movq	%r8, (%rdi,%rcx,8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	jl	<addr>
               	movq	%rax, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movq	%rsi, %r8
               	imulq	%rcx, %r8
               	movq	%r8, (%rdi,%rcx,8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	leaq	0x3e8(%rcx), %rdi
               	movq	%rdi, (%rsi,%rcx,8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %r13
               	movl	$0x3e8, %ebx            # imm = 0x3E8
               	xorl	%r12d, %r12d
               	movq	%r12, %rdi
               	movq	%r13, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x1, %edi
               	movq	%rbx, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	addq	%rax, %r14
               	movl	$0x2, %edi
               	movq	%rbx, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	addq	%rax, %r14
               	movl	$0x3, %edi
               	movq	%rbx, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	addq	%rax, %r14
               	movl	$0x4, %edi
               	movq	%rbx, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	leaq	(%r14,%rax), %rsi
               	xorl	%eax, %eax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	leaq	0x3e8(%rax), %rcx
               	movq	%rbx, %rdx
               	imulq	%rax, %rdx
               	addq	%rdx, %rcx
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	addq	%rdx, %rcx
               	movq	%rbx, %rdx
               	xorq	%rax, %rdx
               	addq	%rcx, %rdx
               	leaq	(%rax,%rax,2), %rcx
               	movslq	%ecx, %rcx
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	addq	%rdx, %rcx
               	addq	%rcx, %r12
               	incq	%rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	cmpq	%r12, %rsi
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
