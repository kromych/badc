
struct_array_member_brace_elision.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	0x10(%rdx), %r10d
               	movl	%r10d, 0x10(%rax)
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movl	$0x40400000, %esi       # imm = 0x40400000
               	movl	$0x40800000, %edi       # imm = 0x40800000
               	movl	$0x40a00000, %r8d       # imm = 0x40A00000
               	xorl	%r9d, %r9d
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	xorl	%r13d, %r13d
               	xorl	%r14d, %r14d
               	xorl	%r15d, %r15d
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rdi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%r8, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %r10d      # imm = 0x40000000
               	movq	%r10, 0x58(%rsp)
               	movl	$0x40400000, %r10d      # imm = 0x40400000
               	movq	%r10, 0x50(%rsp)
               	movl	$0x40800000, %r10d      # imm = 0x40800000
               	movq	%r10, 0x48(%rsp)
               	movl	$0x40a00000, %r10d      # imm = 0x40A00000
               	movq	%r10, 0x40(%rsp)
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movsd	0x58(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movsd	0x50(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movsd	0x48(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movsd	0x40(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %r10d      # imm = 0x40000000
               	movq	%r10, 0x58(%rsp)
               	movl	$0x40400000, %r10d      # imm = 0x40400000
               	movq	%r10, 0x50(%rsp)
               	movl	$0x40800000, %r10d      # imm = 0x40800000
               	movq	%r10, 0x48(%rsp)
               	movl	$0x40a00000, %r10d      # imm = 0x40A00000
               	movq	%r10, 0x40(%rsp)
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movsd	0x58(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movsd	0x50(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movsd	0x48(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movsd	0x40(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %r10d      # imm = 0x40000000
               	movq	%r10, 0x58(%rsp)
               	movl	$0x40400000, %r10d      # imm = 0x40400000
               	movq	%r10, 0x50(%rsp)
               	movl	$0x40800000, %r10d      # imm = 0x40800000
               	movq	%r10, 0x48(%rsp)
               	movl	$0x40a00000, %r10d      # imm = 0x40A00000
               	movq	%r10, 0x40(%rsp)
               	movss	-0x18(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x14(%rbp), %xmm0
               	movsd	0x58(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x10(%rbp), %xmm0
               	movsd	0x50(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xc(%rbp), %xmm0
               	movsd	0x48(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x8(%rbp), %xmm0
               	movsd	0x40(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %r10d      # imm = 0x40000000
               	movq	%r10, 0x58(%rsp)
               	movl	$0x40400000, %r10d      # imm = 0x40400000
               	movq	%r10, 0x50(%rsp)
               	movl	$0x40800000, %r10d      # imm = 0x40800000
               	movq	%r10, 0x48(%rsp)
               	movl	$0x40a00000, %r10d      # imm = 0x40A00000
               	movq	%r10, 0x40(%rsp)
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm14
               	movsd	0x58(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rsi, %xmm14
               	movsd	0x50(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rdi, %xmm14
               	movsd	0x48(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%r8, %xmm14
               	movsd	0x40(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %r10d      # imm = 0x40000000
               	movq	%r10, 0x58(%rsp)
               	movl	$0x40400000, %r10d      # imm = 0x40400000
               	movq	%r10, 0x50(%rsp)
               	movl	$0x40800000, %r10d      # imm = 0x40800000
               	movq	%r10, 0x48(%rsp)
               	movl	$0x40a00000, %r10d      # imm = 0x40A00000
               	movq	%r10, 0x40(%rsp)
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm14
               	movsd	0x58(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rsi, %xmm14
               	movsd	0x50(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rdi, %xmm14
               	movsd	0x48(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%r8, %xmm14
               	movsd	0x40(%rsp), %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rsi, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rbx, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%r12, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%r13, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%r14, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%r15, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
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
