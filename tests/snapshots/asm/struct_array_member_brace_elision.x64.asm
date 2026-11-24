
struct_array_member_brace_elision.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x28, %rsp
               	movss	<rip>, %xmm0
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	0x10(%rcx), %r10d
               	movl	%r10d, 0x10(%rax)
               	movss	<rip>, %xmm2
               	movss	<rip>, %xmm3
               	movss	<rip>, %xmm4
               	movss	<rip>, %xmm5
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm3, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm4, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm5, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movss	<rip>, %xmm1
               	movss	<rip>, %xmm3
               	movss	<rip>, %xmm5
               	movss	<rip>, %xmm4 # <addr>
               	ucomiss	%xmm0, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	%xmm3, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	%xmm5, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm2
               	movss	<rip>, %xmm4
               	movss	<rip>, %xmm5 # <addr>
               	ucomiss	%xmm0, %xmm5
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm5 # <addr>
               	ucomiss	%xmm2, %xmm5
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm5 # <addr>
               	ucomiss	%xmm1, %xmm5
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm3, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm4, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm2 # <addr>
               	xorps	%xmm0, %xmm0
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movss	<rip>, %xmm2 # <addr>
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm2 # <addr>
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm2 # <addr>
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm2 # <addr>
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm2 # <addr>
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm2
               	movss	<rip>, %xmm3
               	movss	<rip>, %xmm4
               	movss	0x8(%rsp), %xmm5
               	ucomiss	%xmm0, %xmm5
               	jp	<addr>
               	jne	<addr>
               	movss	0xc(%rsp), %xmm0
               	ucomiss	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x10(%rsp), %xmm0
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x14(%rsp), %xmm0
               	ucomiss	%xmm3, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x18(%rsp), %xmm0
               	ucomiss	%xmm4, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
