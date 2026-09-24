
call_result_in_place.x64:	file format elf64-x86-64

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

<make>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	leaq	0x1(%rsi), %rcx
               	leaq	0x2(%rsi), %rdx
               	leaq	0x3(%rsi), %rdi
               	movq	-0x20(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<makep>:
               	movq	%rdi, %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	retq

<makeq>:
               	movq	%rdi, %rax
               	negq	%rax
               	movl	%edi, %ecx
               	movl	%eax, %eax
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	retq

<rotate_global>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movq	0x18(%rax), %rdx
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	movq	(%rcx), %rax
               	movq	0x10(%rax), %rcx
               	movq	-0x10(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	leave
               	retq

<rotate_arg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x18(%rsi), %rcx
               	movq	(%rsi), %rdx
               	movq	0x8(%rsi), %rdi
               	movq	0x10(%rsi), %rsi
               	movq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	leave
               	retq

<clobber_global>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movq	%rdi, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x64, (%rcx)
               	movq	(%rax), %rax
               	movq	$0x190, 0x18(%rax)      # imm = 0x190
               	movq	-0x30(%rbp), %rbx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<swap_global>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	cmpq	$0x1, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x2, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x3, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x4, %rdi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<assign_local>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x223d, %rax           # imm = 0x223D
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<through_pointer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
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
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<escaped_to_global>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x4, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x8(%rcx), %rdx
               	cmpq	$0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x10(%rcx), %rdx
               	cmpq	$0x2, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x18(%rcx), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

<escaped_as_argument>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	cmpq	$0x4, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x1, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x2, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x3, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<clobbered_then_assigned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x7, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x8(%rcx), %rdx
               	cmpq	$0x8, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x10(%rcx), %rdx
               	cmpq	$0x9, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x18(%rcx), %rax
               	cmpq	$0xa, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

<escape_across_iterations>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x1, %r12d
               	xorl	%ebx, %ebx
               	leaq	-0x60(%rbp), %r13
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r13)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r13)
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	-0x60(%rbp), %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x1, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x8(%rcx), %rdx
               	cmpq	$0x2, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x10(%rcx), %rdx
               	cmpq	$0x3, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x18(%rcx), %rax
               	cmpq	$0x4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	leaq	-0x60(%rbp), %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x4, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x8(%rcx), %rdx
               	cmpq	$0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x10(%rcx), %rdx
               	cmpq	$0x2, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x18(%rcx), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x3, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x8(%rcx), %rdx
               	cmpq	$0x4, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x10(%rcx), %rdx
               	cmpq	$0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x18(%rcx), %rax
               	cmpq	$0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	jmp	<addr>
               	andq	%rax, %r12
               	leaq	<rip>, %rax
               	leaq	-0x60(%rbp), %rcx
               	movq	%rcx, (%rax)
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<pointer_to_local>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x4, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x8(%rcx), %rdx
               	cmpq	$0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x10(%rcx), %rdx
               	cmpq	$0x2, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x18(%rcx), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

<regs_through_pointer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, (%rbx)
               	movq	%rdx, 0x8(%rbx)
               	cmpq	$0x3, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x8(%rbx), %rax
               	cmpq	$0x6, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<regs_fresh>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	cmpq	$0x54, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<regs_in_registers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x6, %edi
               	callq	<addr>
               	movq	%rdx, %rbx
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rbx, 0x8(%rax)
               	movq	(%rax), %r12
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	leaq	(%r12,%rbx), %rax
               	cmpq	$0x12, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpl	$0x7, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	$-0x7, %edx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

<regs_escaped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	callq	<addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x2, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x8(%rcx), %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<member_of_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x14, %esi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	0x10(%rax), %rbx
               	movl	$0x1e, %edi
               	callq	<addr>
               	leaq	(%rbx,%rdx), %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x52, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	-0x30(%rbp), %rcx
               	movq	-0x10(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	xorl	%eax, %eax
               	leave
               	retq
