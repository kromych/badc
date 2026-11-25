
call_result_in_place.x64:	file format elf64-x86-64

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

<make>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	leaq	0x1(%rsi), %rcx
               	leaq	0x2(%rsi), %rdx
               	leaq	0x3(%rsi), %rdi
               	movq	(%rsp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	addq	$0x18, %rsp
               	retq

<makep>:
               	movq	%rdi, %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	retq

<makeq>:
               	movq	%rdi, %rcx
               	negq	%rcx
               	movl	%edi, %eax
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	retq

<rotate_global>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rcx
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rsi
               	movq	0x10(%rax), %rdi
               	movq	(%rsp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	addq	$0x18, %rsp
               	retq

<rotate_arg>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x18(%rsi), %rcx
               	movq	(%rsi), %rdx
               	movq	0x8(%rsi), %rdi
               	movq	0x10(%rsi), %rsi
               	movq	(%rsp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	addq	$0x18, %rsp
               	retq

<clobber_global>:
               	subq	$0x40, %rsp
               	pushq	%rbx
               	movq	%rdi, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	$0x64, (%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x190, 0x18(%rax)      # imm = 0x190
               	movq	0x10(%rsp), %rbx
               	leaq	0x20(%rsp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq

<swap_global>:
               	movq	<rip>, %rcx # <addr>
               	movq	0x8(%rcx), %rax
               	movq	(%rcx), %rdx
               	retq

<use>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rdi), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rdi), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	retq

<usep>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	retq

<fresh>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	xorl	%eax, %eax
               	cmpq	$0x2, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x1, %rcx
               	cmovneq	%rax, %rdx
               	cmpq	$0x3, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	cmoveq	%rax, %rcx
               	cmpq	$0x4, %rdi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rcx, %rcx
               	cmoveq	%rax, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x28, %rsp
               	retq

<assign_local>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x223d, %rax           # imm = 0x223D
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x28, %rsp
               	retq

<through_pointer>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	0x10(%rsp), %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	leaq	0x10(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	(%rbx), %rax
               	cmpq	$0x9, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x8(%rbx), %rcx
               	cmpq	$0xa, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x10(%rbx), %rcx
               	cmpq	$0xb, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x18(%rbx), %rax
               	cmpq	$0xc, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<escaped_to_global>:
               	subq	$0x48, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	%rax, <rip> # <addr>
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	(%rsp), %rax
               	cmpq	$0x4, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpq	$0x1, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x10(%rsp), %rcx
               	cmpq	$0x2, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x48, %rsp
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<escaped_as_argument>:
               	subq	$0x48, %rsp
               	leaq	(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	movq	0x30(%rsp), %rsi
               	movq	0x38(%rsp), %rdi
               	xorl	%eax, %eax
               	cmpq	$0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x4, %rcx
               	cmovneq	%rax, %rdx
               	cmpq	$0x2, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	cmoveq	%rax, %rcx
               	cmpq	$0x3, %rdi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	addq	$0x48, %rsp
               	retq

<clobbered_then_assigned>:
               	subq	$0x48, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	%rax, <rip> # <addr>
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	(%rsp), %rax
               	cmpq	$0x7, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpq	$0x8, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x10(%rsp), %rcx
               	cmpq	$0x9, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0xa, %rax
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x48, %rsp
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<escape_across_iterations>:
               	subq	$0x70, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x1, %r12d
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	andq	%rax, %r12
               	leaq	0x20(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jge	<addr>
               	leaq	0x20(%rsp), %r13
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r13)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r13)
               	nopl	(%rax)
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x28(%rsp), %rcx
               	cmpq	$0x2, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x30(%rsp), %rcx
               	cmpq	$0x3, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x38(%rsp), %rax
               	cmpq	$0x4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x4, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x28(%rsp), %rcx
               	cmpq	$0x1, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x30(%rsp), %rcx
               	cmpq	$0x2, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x38(%rsp), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x3, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x28(%rsp), %rcx
               	cmpq	$0x4, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x30(%rsp), %rcx
               	cmpq	$0x1, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x38(%rsp), %rax
               	cmpq	$0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	0x60(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	leaq	0x60(%rsp), %rax
               	jmp	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x70, %rsp
               	retq

<pointer_to_local>:
               	subq	$0x48, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	%rax, <rip> # <addr>
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	(%rsp), %rax
               	cmpq	$0x4, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpq	$0x1, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x10(%rsp), %rcx
               	cmpq	$0x2, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x48, %rsp
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<regs_through_pointer>:
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, (%rbx)
               	movq	%rdx, 0x8(%rbx)
               	xorl	%ecx, %ecx
               	cmpq	$0x6, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x3, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	retq

<regs_fresh>:
               	subq	$0x18, %rsp
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	movq	%rax, (%rsp)
               	movq	%rdx, 0x8(%rsp)
               	callq	<addr>
               	cmpq	$0x54, %rax
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x18, %rsp
               	retq

<regs_in_registers>:
               	pushq	%rax
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x6, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r12
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	leaq	(%rbx,%r12), %rsi
               	xorl	%ecx, %ecx
               	cmpl	$0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x12, %rsi
               	cmovneq	%rcx, %rax
               	cmpl	$-0x7, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq

<regs_escaped>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	movq	%rax, (%rsp)
               	movq	%rdx, 0x8(%rsp)
               	xorl	%ecx, %ecx
               	cmpq	$0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x2, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<member_of_call>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	leaq	0x10(%rsp), %rdi
               	movl	$0x14, %esi
               	callq	<addr>
               	movq	0x20(%rsp), %rbx
               	movl	$0x1e, %edi
               	callq	<addr>
               	leaq	(%rbx,%rdx), %rax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq

<main>:
               	subq	$0x38, %rsp
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xb, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xc, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	cmpq	$0x52, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x10(%rsp), %rax
               	movq	(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
