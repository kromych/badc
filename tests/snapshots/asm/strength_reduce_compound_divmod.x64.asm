
strength_reduce_compound_divmod.x64:	file format elf64-x86-64

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

<plain>:
               	subq	$0xf0, %rsp
               	pushq	%rbx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xa, 0x10(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	0x10(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	movq	%rax, %r9
               	movl	0x10(%rsp), %ebx
               	movl	%esi, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x7, 0x18(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	0x18(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	movq	%rax, %r9
               	movl	0x18(%rsp), %ebx
               	movl	%esi, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffff9, 0x20(%rsp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	negq	%rdi
               	imulq	$-0x7, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	0x20(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	movq	%rax, %r9
               	movl	0x20(%rsp), %ebx
               	movl	%esi, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	nopl	(%rax,%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x10, 0x28(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3c, %rax
               	leaq	(%rsi,%rax), %rdi
               	movq	%rdi, %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %rdi
               	subq	%rax, %rdi
               	movl	0x28(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	movq	%rax, %r9
               	movl	0x28(%rsp), %ebx
               	movl	%esi, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffff0, 0x30(%rsp) # imm = 0xFFFFFFF0
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3c, %rax
               	leaq	(%rsi,%rax), %rdi
               	movq	%rdi, %rdx
               	sarq	$0x4, %rdx
               	movq	%rdx, %r8
               	negq	%r8
               	andq	$0xf, %rdi
               	subq	%rax, %rdi
               	movl	0x30(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	movq	%rax, %r9
               	movl	0x30(%rsp), %ebx
               	movl	%esi, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, 0x38(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movl	0x38(%rsp), %edi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	movq	%rax, %rdi
               	movl	0x38(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edi, %esi
               	jne	<addr>
               	nop
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xffffffff, 0x40(%rsp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, %rsi
               	cmpl	$0x80000000, %esi       # imm = 0x80000000
               	je	<addr>
               	movq	%rsi, %rdi
               	negq	%rdi
               	movl	0x40(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	movq	%rax, %r8
               	movl	0x40(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%r8d, %edi
               	jne	<addr>
               	testl	%edx, %edx
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x7fffffff, 0x48(%rsp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0x7fffffff, %rdi, %rax # imm = 0x7FFFFFFF
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	0x48(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	movq	%rax, %r9
               	movl	0x48(%rsp), %ebx
               	movl	%esi, %eax
               	cltd
               	idivl	%ebx
               	nopl	(%rax,%rax)
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x80000000, 0x50(%rsp) # imm = 0x80000000
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x21, %rax
               	leaq	(%rsi,%rax), %rdi
               	movq	%rdi, %rdx
               	sarq	$0x1f, %rdx
               	movq	%rdx, %r8
               	negq	%r8
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	subq	%rax, %rdi
               	movl	0x50(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	movq	%rax, %r9
               	movl	0x50(%rsp), %ebx
               	movl	%esi, %eax
               	cltd
               	idivl	%ebx
               	nop
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xa, 0x58(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %r8d
               	movq	%r8, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rdi # imm = 0x66666667
               	shrq	$0x21, %rdi
               	imulq	$0xa, %rdi, %rax
               	subq	%rax, %r8
               	movl	0x58(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movl	0x58(%rsp), %ebx
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%ebx
               	nopl	(%rax,%rax)
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x7, 0x60(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rdi
               	movl	%edi, %esi
               	imulq	$0x24924925, %rsi, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	shrq	%rdx
               	addq	%rdx, %rax
               	movq	%rax, %r8
               	shrq	$0x2, %r8
               	shrq	$0x2, %rax
               	imulq	$0x7, %rax, %rax
               	subq	%rax, %rsi
               	movl	0x60(%rsp), %r9d
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movl	0x60(%rsp), %ebx
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%ebx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x8, 0x68(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	shrq	$0x3, %rdi
               	movq	%rsi, %r8
               	andq	$0x7, %r8
               	movl	0x68(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movl	0x68(%rsp), %ebx
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%ebx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	nopl	(%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, 0x70(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movl	0x70(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movq	%rax, %rdi
               	movl	0x70(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edi, %esi
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x80000001, 0x78(%rsp) # imm = 0x80000001
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	cmpl	$0x80000001, %esi       # imm = 0x80000001
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	%esi, %edi
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	setae	%al
               	movzbq	%al, %rax
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	imulq	%r11, %rax
               	subq	%rax, %rdi
               	movl	0x78(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movl	0x78(%rsp), %ebx
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%ebx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	nopl	(%rax)
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xee6b2800, 0x80(%rsp) # imm = 0xEE6B2800
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	cmpl	$0xee6b2800, %esi       # imm = 0xEE6B2800
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	%esi, %edi
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	setae	%al
               	movzbq	%al, %rax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	imulq	%r11, %rax
               	subq	%rax, %rdi
               	movl	0x80(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movl	0x80(%rsp), %ebx
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%ebx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xffffffff, 0x88(%rsp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	cmpl	$-0x1, %esi
               	setae	%r8b
               	movzbq	%r8b, %r8
               	movl	%esi, %edi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	setae	%al
               	movzbq	%al, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	imulq	%r11, %rax
               	subq	%rax, %rdi
               	movl	0x88(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movl	0x88(%rsp), %ebx
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%ebx
               	nopl	(%rax)
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0xa, 0x90(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	nopw	%cs:(%rax,%rax)
               	nop
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x2, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0x90(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	0x90(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x3e8, 0x98(%rsp)     # imm = 0xFC18
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %rdi # imm = 0x20C49BA5E353F7CF
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x7, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	negq	%rdi
               	imulq	$-0x3e8, %rdi, %rax     # imm = 0xFC18
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0x98(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	0x98(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0x1000, 0xa0(%rsp)     # imm = 0x1000
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	nopw	%cs:(%rax,%rax)
               	nop
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x34, %rax
               	leaq	(%rsi,%rax), %rdi
               	movq	%rdi, %r8
               	sarq	$0xc, %r8
               	andq	$0xfff, %rdi            # imm = 0xFFF
               	subq	%rax, %rdi
               	movq	0xa0(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	0xa0(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpq	%r9, %r8
               	jne	<addr>
               	nopw	(%rax,%rax)
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x1, 0xa8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rdi
               	negq	%rdi
               	movq	0xa8(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	movq	0xa8(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	nopl	(%rax)
               	cmpq	%r8, %rdi
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, 0xb0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	nopw	%cs:(%rax,%rax)
               	nopw	(%rax,%rax)
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	shrq	%rax
               	leaq	(%rsi,%rax), %rdx
               	movq	%rdx, %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %r8
               	negq	%r8
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rdx, %rdi
               	subq	%rax, %rdi
               	movq	0xb0(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	0xb0(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpq	%r9, %r8
               	jne	<addr>
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0xa, 0xb8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0xb8(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	0xb8(%rsp), %rbx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$0x7, 0xc0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	leaq	(%rax,%rdx), %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movq	0xc0(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	0xc0(%rsp), %rbx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	movq	%rax, 0xc8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	nopw	%cs:(%rax,%rax)
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	imulq	%rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0xc8(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	0xc8(%rsp), %rbx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$0x64, 0xd0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rsi,8), %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$-0x5c28f5c28f5c28f5, %rdi # imm = 0xA3D70A3D70A3D70B
               	movq	%rcx, %rax
               	imulq	%rdi
               	leaq	(%rdx,%rcx), %rax
               	sarq	$0x6, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0x64, %rdi, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movq	0xd0(%rsp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	0xd0(%rsp), %rbx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x3, 0xd8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	nopw	%cs:(%rax,%rax)
               	nopl	(%rax)
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	negq	%rdi
               	imulq	$-0x3, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0xd8(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	0xd8(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0x64, 0xe0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	$0x2, %rax
               	movabsq	$0x28f5c28f5c28f5c3, %rdi # imm = 0x28F5C28F5C28F5C3
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x64, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0xe0(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	0xe0(%rsp), %rbx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$0x7, 0xe8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rsi,8), %rcx
               	nopw	%cs:(%rax,%rax)
               	nopw	%cs:(%rax,%rax)
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	leaq	(%rax,%rdx), %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movq	0xe8(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	0xe8(%rsp), %rbx
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xf0, %rsp
               	retq

<converted>:
               	subq	$0xc0, %rsp
               	pushq	%rbx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, 0x18(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	0x18(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movsbq	%al, %r9
               	movslq	0x18(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	nopw	(%rax,%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffffb, 0x20(%rsp) # imm = 0xFFFFFFFB
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x21, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	negq	%rdi
               	imulq	$-0x5, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	0x20(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movsbq	%al, %r9
               	movslq	0x20(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xffffffff, 0x28(%rsp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movsbq	%al, %rsi
               	movq	%rsi, %rax
               	negq	%rax
               	movsbq	%al, %rdi
               	movslq	0x28(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movsbq	%al, %r8
               	movslq	0x28(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	nopl	(%rax)
               	cmpl	%r8d, %edi
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, 0x30(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	andq	$0xff, %rsi
               	imulq	$0x55555556, %rsi, %rdi # imm = 0x55555556
               	shrq	$0x20, %rdi
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movslq	0x30(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	andq	$0xff, %r8
               	movslq	0x30(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	nopl	(%rax)
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x10, 0x38(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r8
               	shrq	$0x4, %r8
               	movq	%rsi, %r9
               	andq	$0xf, %r9
               	movslq	0x38(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	andq	$0xff, %rdi
               	movslq	0x38(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	nopl	(%rax,%rax)
               	cmpl	%edi, %r8d
               	jne	<addr>
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffff9, 0x40(%rsp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	andq	$0xff, %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	negq	%rax
               	movq	%rax, %r8
               	andq	$0xff, %r8
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movslq	0x40(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	andq	$0xff, %rdi
               	movslq	0x40(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	nop
               	cmpl	%edi, %r8d
               	jne	<addr>
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xa, 0x48(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movswq	%ax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	0x48(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movswq	%ax, %r9
               	movslq	0x48(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xffffffff, 0x50(%rsp) # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movswq	%ax, %rsi
               	movq	%rsi, %rax
               	negq	%rax
               	movswq	%ax, %rdi
               	movslq	0x50(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movswq	%ax, %r8
               	movslq	0x50(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	nopl	(%rax)
               	cmpl	%r8d, %edi
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x3e8, 0x58(%rsp)      # imm = 0x3E8
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	imulq	$0x418938, %rsi, %rdi   # imm = 0x418938
               	shrq	$0x20, %rdi
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movslq	0x58(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movslq	0x58(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x7, 0x60(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	imulq	$0x24924925, %rsi, %rdi # imm = 0x24924925
               	shrq	$0x20, %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movl	0x60(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movl	0x60(%rsp), %ebx
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%ebx
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, 0x68(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %r8d
               	movl	$0xaaaaaaab, %edi       # imm = 0xAAAAAAAB
               	imulq	%r8, %rdi
               	shrq	$0x21, %rdi
               	leaq	(%rdi,%rdi,2), %rax
               	subq	%rax, %r8
               	movl	0x68(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movl	0x68(%rsp), %ebx
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%ebx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	nopw	(%rax,%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x80000000, 0x70(%rsp) # imm = 0x80000000
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movl	%esi, %edi
               	shrq	$0x1f, %rdi
               	movq	%rsi, %r8
               	andq	$0x7fffffff, %r8        # imm = 0x7FFFFFFF
               	movl	0x70(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movl	0x70(%rsp), %ebx
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%ebx
               	nop
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x3, 0x78(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0x78(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	0x78(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	nop
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, 0x80(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	0x80(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movq	0x80(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	testl	%edi, %edi
               	jne	<addr>
               	nopw	(%rax,%rax)
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x7, 0x88(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	leaq	(%rax,%rdx), %rdi
               	shrq	$0x2, %rdi
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0x88(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	0x88(%rsp), %rbx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x7, 0x90(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rdx
               	movl	%edx, %esi
               	imulq	$0x24924925, %rsi, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	shrq	%rdi
               	addq	%rdi, %rax
               	movq	%rax, %r8
               	shrq	$0x2, %r8
               	shrq	$0x2, %rax
               	imulq	$0x7, %rax, %rax
               	subq	%rax, %rsi
               	movl	%edx, %edi
               	movq	0x90(%rsp), %r9
               	movq	%rdi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movq	0x90(%rsp), %rbx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rbx
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$-0x7, 0x98(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %r8
               	movl	%r8d, %edi
               	movabsq	$0x4924924924924925, %rsi # imm = 0x4924924924924925
               	movq	%rdi, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	sarq	%rsi
               	movq	%rsi, %rax
               	shrq	$0x3f, %rax
               	addq	%rsi, %rax
               	movq	%rax, %r9
               	negq	%r9
               	movq	%rsi, %rax
               	shrq	$0x3f, %rax
               	addq	%rsi, %rax
               	negq	%rax
               	imulq	$-0x7, %rax, %rax
               	subq	%rax, %rdi
               	movl	%r8d, %esi
               	movq	0x98(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	movq	0x98(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	nopw	(%rax,%rax)
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0xa, 0xa0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movl	%eax, %esi
               	movq	%rsi, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rdi # imm = 0x66666667
               	shrq	$0x21, %rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0xa0(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movq	0xa0(%rsp), %rbx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x9, 0xa8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movswq	%ax, %rsi
               	movabsq	$-0x1c71c71c71c71c71, %rdi # imm = 0xE38E38E38E38E38F
               	movq	%rsi, %rax
               	mulq	%rdi
               	shrq	$0x3, %rdx
               	movswq	%dx, %rdi
               	leaq	(%rdx,%rdx,8), %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	0xa8(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movswq	%ax, %r9
               	movq	0xa8(%rsp), %rbx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movswq	%dx, %rax
               	nop
               	cmpl	%r9d, %edi
               	jne	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xfffffff6, 0xb0(%rsp) # imm = 0xFFFFFFF6
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	nopw	%cs:(%rax,%rax)
               	nop
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x2, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	negq	%rdi
               	imulq	$-0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	0xb0(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movslq	0xb0(%rsp), %rbx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, 0xb8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	nopw	%cs:(%rax,%rax)
               	nopw	%cs:(%rax,%rax)
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	0xb8(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rax, %r9
               	movslq	0xb8(%rsp), %rbx
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	nopl	(%rax,%rax)
               	cmpq	%r9, %rdi
               	jne	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq

<main>:
               	subq	$0xa0, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	$0x0, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$-0x2, <rip> # <addr>
               	movq	$0x7fffffff, <rip> # imm = 0x7FFFFFFF
                                                # <addr>
               	movq	$-0x80000000, <rip> # imm = 0x80000000
                                                # <addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, <rip> # <addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, <rip> # <addr>
               	movq	$0x7f, <rip> # <addr>
               	movq	$-0x80, <rip> # <addr>
               	movq	$0xff, <rip> # <addr>
               	movq	$0x7fff, <rip> # imm = 0x7FFF
                                                # <addr>
               	movq	$-0x8000, <rip> # imm = 0x8000
                                                # <addr>
               	movq	$0xffff, <rip> # imm = 0xFFFF
                                                # <addr>
               	movabsq	$0x2ceaee21bf46bc00, %rax # imm = 0x2CEAEE21BF46BC00
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x557f8ab2e5e572b1, %rax # imm = 0xAA80754D1A1A8D4F
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x4c3b6fb592d876ce, %rax # imm = 0xB3C4904A6D278932
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x439630bd897b92e7, %rax # imm = 0xBC69CF4276846D19
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x377b2fd56a5b15b4, %rax # imm = 0x377B2FD56A5B15B4
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x64d815deeaf29df3, %rax # imm = 0x64D815DEEAF29DF3
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x991eff24d282dfa, %rax # imm = 0xF66E100DB2D7D206
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x1069e6a57e06665d, %rax # imm = 0x1069E6A57E06665D
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0xa0, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0xa0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rax
               	movl	%eax, 0x88(%rsp)
               	movq	(%rsi,%rcx,8), %rax
               	movl	%eax, 0x90(%rsp)
               	movl	$0xa, 0x98(%rsp)
               	movslq	0x88(%rsp), %rax
               	imulq	$0x66666667, %rax, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movl	%eax, 0x88(%rsp)
               	movslq	0x90(%rsp), %rax
               	movslq	0x98(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movl	%eax, 0x90(%rsp)
               	movl	0x88(%rsp), %eax
               	movl	0x90(%rsp), %edx
               	cmpl	%edx, %eax
               	jne	<addr>
               	movq	(%rsi,%rcx,8), %rax
               	movl	%eax, 0x88(%rsp)
               	movq	(%rsi,%rcx,8), %rax
               	movl	%eax, 0x90(%rsp)
               	movslq	0x88(%rsp), %rdx
               	imulq	$0x66666667, %rdx, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	imulq	$0xa, %rax, %rax
               	subq	%rax, %rdx
               	movl	%edx, 0x88(%rsp)
               	movslq	0x90(%rsp), %rsi
               	movslq	0x98(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movl	%edx, 0x90(%rsp)
               	movl	0x88(%rsp), %eax
               	movl	0x90(%rsp), %edx
               	nopl	(%rax)
               	cmpl	%edx, %eax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rdx,%rax,8), %rdx
               	movl	%edx, 0x28(%rsp,%rax,4)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffff7, 0xa0(%rsp) # imm = 0xFFFFFFF7
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rax
               	movl	0xa0(%rsp), %esi
               	cltd
               	idivl	%esi
               	movslq	%eax, %rdi
               	movslq	0x28(%rsp,%rcx,4), %rax
               	imulq	$0x38e38e39, %rax, %rax # imm = 0x38E38E39
               	sarq	$0x21, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rsi
               	negq	%rsi
               	movl	%esi, 0x28(%rsp,%rcx,4)
               	cmpl	%edi, %esi
               	jne	<addr>
               	cmpl	%edi, %esi
               	jne	<addr>
               	movslq	0xa0(%rsp), %r9
               	movq	%rdi, %rax
               	cqto
               	idivq	%r9
               	imulq	$0x38e38e39, %rsi, %rax # imm = 0x38E38E39
               	sarq	$0x21, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x9, %rax, %rax
               	subq	%rax, %rsi
               	movl	%esi, 0x28(%rsp,%rcx,4)
               	movq	%rsi, %rax
               	cmpl	%edx, %eax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%edi, %edi
               	movl	$0x3, 0xa8(%rsp)
               	leaq	<rip>, %r9 # <addr>
               	movq	(%r9,%rdi,8), %rax
               	movq	%rax, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movq	%rcx, %rdx
               	andq	$-0x800, %rdx           # imm = 0xF800
               	orq	%r8, %rdx
               	movabsq	$-0x100000000, %rbx     # imm = 0xFFFFFFFF00000000
               	andq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rax, %rcx
               	shlq	$0x35, %rcx
               	sarq	$0x35, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movq	%rsi, %r8
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%rcx, %r8
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	andq	%r11, %rsi
               	orq	%r8, %rsi
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	shlq	$0xb, %rax
               	orq	%rax, %rdx
               	movabsq	$-0x100000000, %rcx     # imm = 0xFFFFFFFF00000000
               	andq	%rbx, %rcx
               	orq	%rdx, %rcx
               	andq	$-0xfff801, %r8         # imm = 0xFF0007FF
               	orq	%rax, %r8
               	movabsq	$-0x100000000, %rax     # imm = 0xFFFFFFFF00000000
               	andq	%rsi, %rax
               	orq	%r8, %rax
               	movq	(%r9,%rdi,8), %rdx
               	andq	$0xffffff, %rcx         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %rcx
               	sarq	$0x18, %rdx
               	andq	$0xffffff, %rax         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x35, %rdx
               	sarq	$0x35, %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movq	%rax, %rsi
               	andq	$-0x800, %rsi           # imm = 0xF800
               	orq	%rdx, %rsi
               	movabsq	$-0x100000000, %rbx     # imm = 0xFFFFFFFF00000000
               	andq	%rax, %rbx
               	movl	%esi, %r9d
               	orq	%r9, %rbx
               	movq	%rcx, %rax
               	shlq	$0x35, %rax
               	sarq	$0x35, %rax
               	movslq	0xa8(%rsp), %r8
               	cqto
               	idivq	%r8
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	movq	%rcx, %r8
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%rax, %r8
               	movabsq	$-0x100000000, %r12     # imm = 0xFFFFFFFF00000000
               	andq	%rcx, %r12
               	movl	%r8d, %eax
               	orq	%rax, %r12
               	sarq	$0xb, %r9
               	andq	$0x1fff, %r9            # imm = 0x1FFF
               	imulq	$0x55555556, %r9, %rcx  # imm = 0x55555556
               	shrq	$0x20, %rcx
               	andq	$-0xfff801, %rsi        # imm = 0xFF0007FF
               	shlq	$0xb, %rcx
               	orq	%rcx, %rsi
               	movabsq	$-0x100000000, %rcx     # imm = 0xFFFFFFFF00000000
               	andq	%rbx, %rcx
               	movl	%esi, %edx
               	orq	%rdx, %rcx
               	sarq	$0xb, %rax
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	movslq	0xa8(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	andq	$-0xfff801, %r8         # imm = 0xFF0007FF
               	shlq	$0xb, %rax
               	orq	%rax, %r8
               	movabsq	$-0x100000000, %rsi     # imm = 0xFFFFFFFF00000000
               	andq	%r12, %rsi
               	movl	%r8d, %eax
               	orq	%rax, %rsi
               	movq	%rcx, %rax
               	sarq	$0x18, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movabsq	$0x5555555555555556, %r8 # imm = 0x5555555555555556
               	imulq	%r8
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	andq	$0xffffff, %rcx         # imm = 0xFFFFFF
               	shlq	$0x18, %rax
               	orq	%rax, %rcx
               	movq	%rsi, %rax
               	sarq	$0x18, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movslq	0xa8(%rsp), %r8
               	cqto
               	idivq	%r8
               	andq	$0xffffff, %rsi         # imm = 0xFFFFFF
               	shlq	$0x18, %rax
               	orq	%rax, %rsi
               	movq	%rcx, %rax
               	shlq	$0x35, %rax
               	sarq	$0x35, %rax
               	movq	%rsi, %rdx
               	shlq	$0x35, %rdx
               	sarq	$0x35, %rdx
               	cmpl	%edx, %eax
               	jne	<addr>
               	movl	%ecx, %eax
               	sarq	$0xb, %rax
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	movl	%esi, %edx
               	sarq	$0xb, %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	cmpl	%edx, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	sarq	$0x18, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movq	%rsi, %rdx
               	sarq	$0x18, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	nopl	(%rax)
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	<rip>, %r9 # <addr>
               	movq	(%r9,%rdi,8), %rax
               	movq	%rax, %r8
               	andq	$0x7ff, %r8             # imm = 0x7FF
               	movq	%rsi, %rdx
               	andq	$-0x800, %rdx           # imm = 0xF800
               	orq	%r8, %rdx
               	movabsq	$-0x100000000, %rbx     # imm = 0xFFFFFFFF00000000
               	andq	%rsi, %rbx
               	orq	%rdx, %rbx
               	movq	%rax, %rsi
               	shlq	$0x35, %rsi
               	sarq	$0x35, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movq	%rcx, %r8
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%rsi, %r8
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	andq	%r11, %rcx
               	orq	%r8, %rcx
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	andq	$-0xfff801, %rdx        # imm = 0xFF0007FF
               	shlq	$0xb, %rax
               	orq	%rax, %rdx
               	movabsq	$-0x100000000, %rsi     # imm = 0xFFFFFFFF00000000
               	andq	%rbx, %rsi
               	orq	%rdx, %rsi
               	andq	$-0xfff801, %r8         # imm = 0xFF0007FF
               	orq	%rax, %r8
               	movabsq	$-0x100000000, %rax     # imm = 0xFFFFFFFF00000000
               	andq	%rcx, %rax
               	orq	%r8, %rax
               	movq	(%r9,%rdi,8), %rcx
               	andq	$0xffffff, %rsi         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rsi
               	sarq	$0x18, %rcx
               	andq	$0xffffff, %rax         # imm = 0xFFFFFF
               	shlq	$0x18, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x35, %rcx
               	sarq	$0x35, %rcx
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movq	%rax, %r8
               	andq	$-0x800, %r8            # imm = 0xF800
               	orq	%rcx, %r8
               	movabsq	$-0x100000000, %r12     # imm = 0xFFFFFFFF00000000
               	andq	%rax, %r12
               	movl	%r8d, %ecx
               	orq	%rcx, %r12
               	movq	%rsi, %r9
               	shlq	$0x35, %r9
               	sarq	$0x35, %r9
               	movslq	0xa8(%rsp), %rbx
               	movq	%r9, %rax
               	cqto
               	idivq	%rbx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movq	%rsi, %r9
               	andq	$-0x800, %r9            # imm = 0xF800
               	orq	%rdx, %r9
               	movabsq	$-0x100000000, %r13     # imm = 0xFFFFFFFF00000000
               	andq	%rsi, %r13
               	movl	%r9d, %ebx
               	orq	%rbx, %r13
               	sarq	$0xb, %rcx
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	andq	$-0xfff801, %r8         # imm = 0xFF0007FF
               	shlq	$0xb, %rcx
               	orq	%rcx, %r8
               	movabsq	$-0x100000000, %rsi     # imm = 0xFFFFFFFF00000000
               	andq	%r12, %rsi
               	movl	%r8d, %eax
               	orq	%rax, %rsi
               	sarq	$0xb, %rbx
               	andq	$0x1fff, %rbx           # imm = 0x1FFF
               	movslq	0xa8(%rsp), %rcx
               	movq	%rbx, %rax
               	cqto
               	idivq	%rcx
               	andq	$-0xfff801, %r9         # imm = 0xFF0007FF
               	shlq	$0xb, %rdx
               	orq	%rdx, %r9
               	movabsq	$-0x100000000, %rcx     # imm = 0xFFFFFFFF00000000
               	andq	%r13, %rcx
               	movl	%r9d, %eax
               	orq	%rax, %rcx
               	movq	%rsi, %r8
               	sarq	$0x18, %r8
               	shlq	$0x18, %r8
               	sarq	$0x18, %r8
               	movabsq	$0x5555555555555556, %r9 # imm = 0x5555555555555556
               	movq	%r8, %rax
               	imulq	%r9
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %r8
               	andq	$0xffffff, %rsi         # imm = 0xFFFFFF
               	shlq	$0x18, %r8
               	orq	%r8, %rsi
               	movq	%rcx, %r8
               	sarq	$0x18, %r8
               	shlq	$0x18, %r8
               	sarq	$0x18, %r8
               	movslq	0xa8(%rsp), %r9
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	andq	$0xffffff, %rcx         # imm = 0xFFFFFF
               	shlq	$0x18, %rdx
               	orq	%rdx, %rcx
               	movq	%rsi, %rax
               	shlq	$0x35, %rax
               	sarq	$0x35, %rax
               	movq	%rcx, %rdx
               	shlq	$0x35, %rdx
               	sarq	$0x35, %rdx
               	cmpl	%edx, %eax
               	jne	<addr>
               	movl	%esi, %eax
               	sarq	$0xb, %rax
               	andq	$0x1fff, %rax           # imm = 0x1FFF
               	movl	%ecx, %edx
               	sarq	$0xb, %rdx
               	andq	$0x1fff, %rdx           # imm = 0x1FFF
               	cmpl	%edx, %eax
               	jne	<addr>
               	movq	%rsi, %rax
               	sarq	$0x18, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movq	%rcx, %rdx
               	sarq	$0x18, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	incq	%rdi
               	nopl	(%rax)
               	cmpl	$0x18, %edi
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0xa0, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	jmp	<addr>
