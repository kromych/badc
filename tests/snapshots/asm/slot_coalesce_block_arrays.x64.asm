
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
               	jge	<addr>
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
               	jge	<addr>
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
               	jge	<addr>
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
               	jge	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %r12
               	movl	$0x3e8, %ebx            # imm = 0x3E8
               	xorl	%edi, %edi
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x1, %edi
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	%rax, %r13
               	movl	$0x2, %edi
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	%rax, %r13
               	movl	$0x3, %edi
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	%rax, %r13
               	movl	$0x4, %edi
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	callq	<addr>
               	leaq	(%r13,%rax), %rdi
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	cmpl	%r12d, %eax
               	jge	<addr>
               	leaq	0x3e8(%rax), %rdx
               	movq	%rbx, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rdx
               	movq	%rbx, %rsi
               	subq	%rax, %rsi
               	addq	%rsi, %rdx
               	movq	%rbx, %rsi
               	xorq	%rax, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rax,%rax,2), %rsi
               	movslq	%esi, %rsi
               	addq	$0x3e8, %rsi            # imm = 0x3E8
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	%r12d, %eax
               	jl	<addr>
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
