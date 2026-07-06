
reg_alloc_callee_bank_call_block_before_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<qs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r12
               	movslq	%esi, %rsi
               	movslq	%r12d, %r12
               	cmpq	%r12, %rsi
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rsi,%r12), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	$0x1, %rax
               	movslq	(%rbx,%rax,4), %rax
               	movq	%r12, %rdx
               	movq	%rsi, %r13
               	movslq	%r13d, %rcx
               	movslq	%edx, %rdi
               	cmpq	%rdi, %rcx
               	jg	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%r13d, %rsi
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	%r13d, %rcx
               	movslq	(%rbx,%rcx,4), %rcx
               	cmpq	%rax, %rcx
               	jge	<addr>
               	movslq	%r13d, %rcx
               	leaq	0x1(%rcx), %r13
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movslq	(%rbx,%rcx,4), %rcx
               	cmpq	%rax, %rcx
               	jle	<addr>
               	movslq	%edx, %rcx
               	leaq	-0x1(%rcx), %rdx
               	jmp	<addr>
               	movslq	%r13d, %rcx
               	movslq	%edx, %rdi
               	cmpq	%rdi, %rcx
               	jg	<addr>
               	movslq	%r13d, %rcx
               	movslq	(%rbx,%rcx,4), %rdi
               	movslq	%edx, %r8
               	movslq	(%rbx,%r8,4), %r8
               	movl	%r8d, (%rbx,%rcx,4)
               	movslq	%edx, %rcx
               	movl	%edi, (%rbx,%rcx,4)
               	incq	%r13
               	movslq	%edx, %rcx
               	leaq	-0x1(%rcx), %rdx
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movl	$0x3039, %edx           # imm = 0x3039
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x40, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	movl	%edx, %eax
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	movl	%eax, %eax
               	addq	$0x3039, %rax           # imm = 0x3039
               	movl	%eax, %edx
               	leaq	-0x100(%rbp), %rax
               	movslq	%ecx, %rsi
               	movl	%edx, %edi
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	movl	%edi, (%rax,%rsi,4)
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x3f, %edx
               	callq	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rax
               	cmpq	$0x40, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rax
               	movslq	%ecx, %rdx
               	movslq	(%rax,%rdx,4), %rax
               	leaq	-0x100(%rbp), %rdx
               	leaq	-0x1(%rcx), %rsi
               	movslq	%esi, %rsi
               	movslq	(%rdx,%rsi,4), %rdx
               	cmpq	%rdx, %rax
               	jge	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
