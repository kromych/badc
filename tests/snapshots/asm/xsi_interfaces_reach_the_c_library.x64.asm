
xsi_interfaces_reach_the_c_library.x64:	file format elf64-x86-64

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

<visit>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r12
               	movq	%rcx, %rbx
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	(%rbx), %eax
               	testl	%eax, %eax
               	jle	<addr>
               	movslq	(%rbx), %rax
               	leaq	(%rdi,%rax), %r13
               	cmpl	$0x0, 0x4(%rbx)
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rdx # <addr>
               	cmpl	$0x5, %r12d
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	0x4(%rbx), %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, (%rdx)
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x2f, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x1(%rax), %rsi
               	jmp	<addr>

<files>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1b8, %rsp            # imm = 0x1B8
               	pushq	%rbx
               	leaq	-0x1b0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x190(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x190(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	movl	$0x60, %esi
               	leaq	<rip>, %rdx
               	leaq	-0x190(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movl	$0x60, %esi
               	leaq	<rip>, %rdx
               	leaq	-0x190(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x150(%rbp), %rdi
               	movl	$0x1180, %esi           # imm = 0x1180
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x64, %rdi
               	leaq	-0xf0(%rbp), %rsi
               	movl	$0x1180, %edx           # imm = 0x1180
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x78(%rbp), %eax
               	andq	$0xf000, %rax           # imm = 0xF000
               	cmpl	$0x1000, %eax           # imm = 0x1000
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x1b0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x190(%rbp), %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jl	<addr>
               	leaq	-0x1b0(%rbp), %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xf0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	leaq	-0x190(%rbp), %rdi
               	leaq	-<rip>, %rsi # <addr>
               	movl	$0x4, %edx
               	movl	$0x9, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x190(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<numbers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movzwq	0xc(%rcx), %r10
               	movw	%r10w, 0xc(%rax)
               	xorl	%eax, %eax
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %edi
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3fb6980226f358e2, %rax # imm = 0x3FB6980226F358E2
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movabsq	$0x3d719799812dea11, %rax # imm = 0x3D719799812DEA11
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3fe8ffb207d66b97, %rax # imm = 0x3FE8FFB207D66B97
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movabsq	$0x3d719799812dea11, %rax # imm = 0x3D719799812DEA11
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x2, %edi
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3ffa69322a45a120, %rax # imm = 0x3FFA69322A45A120
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movabsq	$0x3d719799812dea11, %rax # imm = 0x3D719799812DEA11
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x40, %rax
               	jne	<addr>
               	movl	$0x40, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	xorl	%eax, %eax
               	movsd	0x18(%rsp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jae	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rax, %rbx
               	jne	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %edi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<strings_and_process>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	leaq	-0x18(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x0, (%rax)
               	movb	$0x0, 0x4(%rax)
               	leaq	<rip>, %rsi
               	movl	$0x2c, %edx
               	movl	$0x8, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	leaq	0x3(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%edi, %edi
               	movl	%edi, (%rax)
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$-0x14, %ebx
               	jl	<addr>
               	cmpl	$0x14, %ebx
               	jg	<addr>
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x19, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0x8(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x4(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<signals>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movl	$0xa, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	movl	$0xa, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movl	$0xc, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	movl	$0xc, %edi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x22, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
