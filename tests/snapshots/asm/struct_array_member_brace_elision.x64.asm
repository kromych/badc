
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
               	subq	$0x20, %rsp
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	0x10(%rdx), %r10d
               	movl	%r10d, 0x10(%rcx)
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movl	$0x40a00000, %edi       # imm = 0x40A00000
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
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
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movl	$0x40a00000, %edi       # imm = 0x40A00000
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
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
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40a00000, %edi       # imm = 0x40A00000
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
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
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x7, %edx
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rcx, %xmm15
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
               	leave
               	retq
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
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movl	$0x40a00000, %edi       # imm = 0x40A00000
               	movss	-0x18(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x14(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x10(%rbp), %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0xc(%rbp), %xmm0
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x8(%rbp), %xmm0
               	movq	%rdi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
